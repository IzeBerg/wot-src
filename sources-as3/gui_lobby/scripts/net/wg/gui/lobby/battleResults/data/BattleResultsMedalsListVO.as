package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.VO.AchievementProfileVO;
   
   public class BattleResultsMedalsListVO extends AchievementProfileVO
   {
       
      
      public var unic:Boolean = false;
      
      public var rare:Boolean = false;
      
      public var title:String = "";
      
      public var isEpic:Boolean = false;
      
      public var specialIcon:String = "";
      
      public var customData:Object;
      
      public function BattleResultsMedalsListVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.customData = null;
         super.onDispose();
      }
   }
}
