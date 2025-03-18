pub trait Key {
    fn compare(data1: &[u8], data2: &[u8]) -> std::cmp::Ordering;
}
