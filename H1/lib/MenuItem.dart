class MenuItem{
    String name;
    double price;
    double? discountPercent;

    MenuItem(
        this.name, 
        this.price,
        {this.discountPercent}
    );

    double finalPrice(){
        final discount = discountPercent ?? 0;
        return price - (price * discount / 100);
    }
}

    void main() {
        List<MenuItem> menuItems = [
            MenuItem('Burger', 20000, discountPercent: 10),
            MenuItem('Pizza', 25000),
            MenuItem('Salad', 18000, discountPercent: 10),
            MenuItem('Iced Tea', 12000),
            MenuItem('Ice Cream', 10000),
        ];

        List<String> menuItemNames = menuItems.map((item) => item.name).toList();

        List<MenuItem> cheapItems = menuItems.where((item) => item.finalPrice() < 15000).toList();

        double totalPrice = menuItems.fold(0, (sum, item) => sum + item.finalPrice());

        print(menuItemNames);
        print(cheapItems.map((item) => item.name).toList());
        print(totalPrice);
    }

