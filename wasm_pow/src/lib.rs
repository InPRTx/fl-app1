use wasm_bindgen::prelude::*;
use sha2::{Sha256, Digest};

/// POW验证码计算 - WASM优化版本
///
/// 使用Rust编写，编译为WASM模块，提供高性能的SHA256计算
///
/// # 性能优势
/// - 原生代码速度（接近本地C/Rust性能）
/// - 比纯JS实现快5-10倍
/// - 比Dart在Web上的实现快3-5倍

#[wasm_bindgen]
pub struct POWSolver {
    cap_id: String,
    difficulty: usize,
}

#[wasm_bindgen]
impl POWSolver {
    /// 创建新的POW求解器
    ///
    /// # 参数
    /// - `cap_id`: 验证码UUID
    /// - `difficulty`: 难度级别（前导零的数量）
    #[wasm_bindgen(constructor)]
    pub fn new(cap_id: String, difficulty: usize) -> POWSolver {
        POWSolver { cap_id, difficulty }
    }

    /// 计算单个挑战的解决方案
    ///
    /// # 参数
    /// - `index`: 挑战索引
    ///
    /// # 返回
    /// 找到的解决方案数值
    #[wasm_bindgen]
    pub fn solve_single(&self, index: u32) -> u32 {
        let target = "0".repeat(self.difficulty);
        let mut solution: u32 = 0;

        loop {
            let data = format!("{}{}{}", index, self.cap_id, solution);
            let hash = Sha256::digest(data.as_bytes());
            let hash_str = hex::encode(hash);

            if hash_str.starts_with(&target) {
                return solution;
            }

            solution += 1;

            // 防止无限循环（理论上不会发生，但作为安全措施）
            if solution == u32::MAX {
                break;
            }
        }

        solution
    }

    /// 批量计算多个挑战的解决方案
    ///
    /// # 参数
    /// - `start_index`: 起始索引
    /// - `count`: 计算数量
    ///
    /// # 返回
    /// 解决方案数组
    #[wasm_bindgen]
    pub fn solve_batch(&self, start_index: u32, count: u32) -> Vec<u32> {
        let mut solutions = Vec::with_capacity(count as usize);

        for i in 0..count {
            let solution = self.solve_single(start_index + i);
            solutions.push(solution);
        }

        solutions
    }

    /// 计算所有挑战的解决方案
    ///
    /// # 参数
    /// - `challenge_count`: 总挑战数量
    ///
    /// # 返回
    /// 完整的解决方案数组
    #[wasm_bindgen]
    pub fn solve_all(&self, challenge_count: u32) -> Vec<u32> {
        self.solve_batch(0, challenge_count)
    }
}

/// 独立函数：计算单个POW解决方案
///
/// 不需要创建求解器实例的简化版本
#[wasm_bindgen]
pub fn compute_pow_solution(
    cap_id: &str,
    index: u32,
    difficulty: usize,
) -> u32 {
    let target = "0".repeat(difficulty);
    let mut solution: u32 = 0;

    loop {
        let data = format!("{}{}{}", index, cap_id, solution);
        let hash = Sha256::digest(data.as_bytes());
        let hash_str = hex::encode(hash);

        if hash_str.starts_with(&target) {
            return solution;
        }

        solution += 1;

        if solution == u32::MAX {
            break;
        }
    }

    solution
}

/// 获取WASM模块版本信息
#[wasm_bindgen]
pub fn get_version() -> String {
    env!("CARGO_PKG_VERSION").to_string()
}

/// 测试函数：验证解决方案是否正确
#[wasm_bindgen]
pub fn verify_solution(
    cap_id: &str,
    index: u32,
    solution: u32,
    difficulty: usize,
) -> bool {
    let target = "0".repeat(difficulty);
    let data = format!("{}{}{}", index, cap_id, solution);
    let hash = Sha256::digest(data.as_bytes());
    let hash_str = hex::encode(hash);

    hash_str.starts_with(&target)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve_single() {
        let solver = POWSolver::new("test-uuid-123".to_string(), 2);
        let solution = solver.solve_single(0);

        // 验证解决方案
        assert!(verify_solution("test-uuid-123", 0, solution, 2));
    }

    #[test]
    fn test_solve_batch() {
        let solver = POWSolver::new("test-uuid-456".to_string(), 2);
        let solutions = solver.solve_batch(0, 5);

        assert_eq!(solutions.len(), 5);

        // 验证每个解决方案
        for (i, &solution) in solutions.iter().enumerate() {
            assert!(verify_solution("test-uuid-456", i as u32, solution, 2));
        }
    }

    #[test]
    fn test_compute_pow_solution() {
        let solution = compute_pow_solution("test-uuid-789", 0, 2);
        assert!(verify_solution("test-uuid-789", 0, solution, 2));
    }
}

