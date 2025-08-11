import 'package:cargaproductos/feactures/screens.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
     GoRoute(
      path: '/cargarProducto',
      builder: (context, state) => const cargarProducto(),
    ),
     GoRoute(
      path: '/registrarCliente',
      builder: (context, state) => const registrarCliente(),
    ),
     GoRoute(
      path: '/operacionesCliente',
      builder: (context, state) => const buscarCliente(),
    )
  ]
);
