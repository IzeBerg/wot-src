package net.wg.gui.components.advanced
{
   public class ReserveTypesUIWithFill extends ModuleTypesUIWithFill
   {
      
      public static const LEVELS_WITHOUT_GLOW:int = 10;
      
      public static const GLOW_BIG_ENDING:String = "BigGlow";
      
      public static const NO_GLOW_BIG_ENDING:String = "Big";
      
      public static const GLOW_ENDING:String = "Glow";
       
      
      public function ReserveTypesUIWithFill()
      {
         super();
      }
      
      override public function setModuleTypeIcon(param1:String) : void
      {
         if(param1 != MODULE_TYPE_NONE)
         {
            moduleIcon.source = RES_ICONS.getReserveTypesIcon(param1);
         }
         else
         {
            moduleIcon.source = null;
         }
      }
   }
}
