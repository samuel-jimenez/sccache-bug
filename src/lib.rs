use std::fmt::{Debug, Display};
use zerocopy::{AsBytes, FromBytes, FromZeroes};

#[derive(
    Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, AsBytes, FromZeroes, FromBytes, Hash,
)]
#[repr(transparent)]
pub struct NodeId(u64);

impl Display for NodeId {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let id = self.0;
        write!(f, "{}", id)
    }
}

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

impl redb::Value for NodeId {
    type SelfType<'b>
        = NodeId
    where
        Self: 'b;

    type AsBytes<'a> = &'a [u8];

    fn fixed_width() -> Option<usize> {
        Some(8)
    }

    fn from_bytes<'a>(data: &'a [u8]) -> Self::SelfType<'a>
    where
        Self: 'a,
    {
        NodeId::read_from(data).unwrap()
    }

    fn as_bytes<'a, 'b: 'a>(value: &'a Self::SelfType<'b>) -> Self::AsBytes<'a>
    where
        Self: 'a,
        Self: 'b,
    {
        AsBytes::as_bytes(value)
    }

    fn type_name() -> redb::TypeName {
        redb::TypeName::new("NodeId")
    }
}

impl<'a> redb::Key for NodeId {
    fn compare(data1: &[u8], data2: &[u8]) -> std::cmp::Ordering {
        data1.cmp(data2)
    }
}
