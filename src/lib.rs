pub struct NodeId(u64);

impl<'a> test_lib::Key for NodeId {
    fn compare(data1: &[u8], data2: &[u8]) -> std::cmp::Ordering {
        data1.cmp(data2)
    }
}
