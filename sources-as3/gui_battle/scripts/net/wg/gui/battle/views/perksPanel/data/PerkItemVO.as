package net.wg.gui.battle.views.perksPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PerkItemVO extends DAAPIDataClass
   {
      
      public static const STATE_INACTIVE:int = 0;
      
      public static const STATE_ACTIVE:int = 1;
       
      
      public var perkName:String = "";
      
      public var duration:int = -1;
      
      public var lifeTime:int = -1;
      
      public var state:int = -1;
      
      public function PerkItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
