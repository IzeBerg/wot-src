package net.wg.gui.login.impl
{
   import flash.utils.getDefinitionByName;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   
   public class RudimentarySwfOnLoginCheckingHelper
   {
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY:String = "rudimentaryGCL";
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY2:String = "rudimentaryGCL2";
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY_DYNAMIC:String = "rudimentaryGCLD";
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY_DYNAMIC2:String = "rudimentaryGCLD2";
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY_BATTLE_DYNAMIC:String = "rudimentaryGCLBD";
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_POPOVERS:String = "rudimentaryPopovers";
      
      private static const RUDIMENTARY_SWF_BY_LINKAGE_ICON_LIBRARY:String = "rudimentaryIconLibrary";
      
      private static const RUDIMENTARY_SWF_LIST:Vector.<String> = new <String>[RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY,RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY2,RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY_DYNAMIC,RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY_DYNAMIC2,RUDIMENTARY_SWF_BY_LINKAGE_GUI_CONTROLS_LOBBY_BATTLE_DYNAMIC,RUDIMENTARY_SWF_BY_LINKAGE_POPOVERS,RUDIMENTARY_SWF_BY_LINKAGE_ICON_LIBRARY];
      
      private static var _instance:RudimentarySwfOnLoginCheckingHelper;
      
      private static var _allowInstantiation:Boolean = false;
       
      
      public function RudimentarySwfOnLoginCheckingHelper()
      {
         super();
         App.utils.asserter.assert(_allowInstantiation,"Error: Instantiation failed: Use RudimentarySwfOnLoginCheckingHelper.instance() instead of new.");
      }
      
      public static function get instance() : RudimentarySwfOnLoginCheckingHelper
      {
         if(!_instance)
         {
            _allowInstantiation = true;
            _instance = new RudimentarySwfOnLoginCheckingHelper();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function checkRudimentarySwf() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = ": must not load into login screen!";
         var _loc3_:String = ", ";
         var _loc4_:Boolean = false;
         for each(_loc1_ in RUDIMENTARY_SWF_LIST)
         {
            try
            {
               getDefinitionByName(_loc1_);
               _loc2_ = _loc3_ + _loc1_ + _loc2_;
               _loc4_ = true;
            }
            catch(e:ReferenceError)
            {
            }
         }
         if(_loc4_)
         {
            _loc2_ = _loc2_.substr(_loc3_.length);
            App.utils.asserter.assert(!_loc4_,_loc2_,InfrastructureException);
         }
      }
   }
}
