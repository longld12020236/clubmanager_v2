Organization.create!(
  name: "Framgia Viet Nam",
  description: "Framgia Việt Nam là công ty IT Nhật Bản chuyên thiết kế, phát
    triển ứng dụng, Games chạy trên Smart phone, nền tảng các mạng xã hội,
    sản xuất và phát triển ứng dụng website.",
  phone: "(0166) 990-9325",
  email: "Framgia@framgia.com",
  location: "6th floor, Vinh Trung Plaza, 255 - 257 Hung Vuong, Hai Chau, Da Nang"
)

Organization.create!(
  name: "Another",
  description: "This is a default organization",
  phone: "",
  email: "default@framgia.com",
  location: "6th floor, Vinh Trung Plaza, 255 - 257 Hung Vuong, Hai Chau, Da Nang"
)

User.create!(
  email: "mahoangtienthanh@gmail.com",
  organization_id: 1,
  full_name: "Thanh ManCi",
  password: "mahoangtienthanh@gmail.com",
  phone: "0966.077.747",
  chatwork: "59733356",
  role: 1
)

