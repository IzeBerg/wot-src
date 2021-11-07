package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.gameloading.GameLoading;
   import net.wg.gui.login.impl.components.LoginLogos;
   import net.wg.gui.login.impl.ev.LoginLogosEvent;
   
   public class ClassManagerGameLoadingMeta
   {
      
      public static const NET_WG_GUI_GAMELOADING_GAMELOADING:Class = GameLoading;
      
      public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_LOGINLOGOS:Class = LoginLogos;
      
      public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINLOGOSEVENT:Class = LoginLogosEvent;
       
      
      public function ClassManagerGameLoadingMeta()
      {
         super();
      }
   }
}
