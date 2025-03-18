use std::fmt::Debug;

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
#[repr(transparent)]
pub struct NodeId(u64);

impl From<u64> for NodeId {
    fn from(id: u64) -> Self {
        NodeId(id)
    }
}

impl NodeId {
    pub const EMPTY: Self = NodeId(0);

    pub fn is_empty(&self) -> bool {
        self == &Self::EMPTY
    }
}

impl<'a> test_lib::Key for NodeId {
    fn compare(data1: &[u8], data2: &[u8]) -> std::cmp::Ordering {
        data1.cmp(data2)
    }
}
