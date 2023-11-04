class StorageSize {
  int? totalSize;
  int? availableSize;

  StorageSize({
    this.totalSize,
    this.availableSize,
  });

  StorageSize copyWith({
    int? totalSize,
    int? availableSize,
  }) {
    return StorageSize(
      totalSize: totalSize ?? this.totalSize,
      availableSize: availableSize ?? this.availableSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSize': totalSize,
      'availableSize': availableSize,
    };
  }

  factory StorageSize.fromJson(Map<String, dynamic> json) {
    return StorageSize(
      totalSize: json['totalSize'] as int?,
      availableSize: json['availableSize'] as int?,
    );
  }

  @override
  String toString() => "StorageSize(totalSize: $totalSize,availableSize: $availableSize)";

  @override
  int get hashCode => Object.hash(totalSize, availableSize);

  @override
  bool operator ==(Object other) => identical(this, other) || other is StorageSize && runtimeType == other.runtimeType && totalSize == other.totalSize && availableSize == other.availableSize;
}
