package net.wg.gui.battle.views.battleHint.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleHintVO extends DAAPIDataClass
   {
       
      
      public var message:String = "";
      
      public var messageHighlight:String = "";
      
      public var iconSource:String = "";
      
      public var context:Object = null;
      
      public var timer:int = 0;
      
      public function BattleHintVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.context = App.utils.data.cleanupDynamicObject(this.context);
         super.onDispose();
      }
   }
}
