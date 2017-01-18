#![feature(test)]
extern crate test;
extern crate libvg;

use libvg::utf8::to_utf8;
use std::ffi::{CStr, CString};
use test::Bencher;

#[bench]
fn bench_utf8(b: &mut Bencher) {
    let encoding = CString::new("1252".as_bytes()).unwrap();
    let message = CString::new("e".as_bytes()).unwrap();

    let both = [encoding.as_ptr(), message.as_ptr()];

    b.iter(|| to_utf8(2, both.as_ptr()))
}

#[bench]
fn bench_derp(b: &mut Bencher) {
    b.iter(|| {;})
}
