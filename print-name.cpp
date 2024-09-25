#include <CL/sycl.hpp>
#include <iostream>

int main() {
    // Create a SYCL queue (default device selector)
    sycl::queue q;

    // Get the device used by the queue
    const sycl::device &device = q.get_device();

    // Print the device name
    std::cout << "Using device: " << device.get_info<sycl::info::device::name>() << std::endl;
    std::cout << "Using platform: " << device.get_platform().get_info<sycl::info::platform::name>() << std::endl;

    return 0;
}
