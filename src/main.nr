use dep::std;
use dep::std::unsafe::zeroed;


global PRIME: u32 = 16777619;

fn main(value: u32, hash_value: pub u32){
    let calculated_hash_value = calculate_hash(value);
    assert(calculated_hash_value == hash_value);
}

fn calculate_hash(num: u32) -> u32 {
    let size: Field = 2.pow_32(32);
    let size_as_u64: u64 = size as u64;
    let mut hash_value: u64 = 0x811C9DC5;
    let prime: u64 = PRIME as u64;
    let num_as_field: Field = num as Field;
    let num_as_bytes = num_as_field.to_be_bytes(4);
  for i in 0..4{
        let product = (hash_value * prime) % size_as_u64;
        let byte_as_64: u64 = num_as_bytes[i] as u64;
        hash_value = product ^ byte_as_64;
    }
    hash_value as u32
}


#[test]
fn test_1() {
    let num = 127561628;
    main(num, 0x71233de7);
    // assert(hash == 0x71233de7);
}
#[test]
fn test_2() {
    let num = 237261828;
    main(num, 0x7F51D567);
    // assert(hash == 0x7F51D567);
}
#[test]
fn test_3() {
    let num = 596214892;
    main(num, 0x3F0C8995);
    // assert(hash == 0x3F0C8995);
}