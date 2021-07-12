package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter
{
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyalePlatoonVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class BattleRoyalePlatoonRenderer extends ListItemRenderer
   {
      
      private static const ENEMY:String = "tank_small_platoon";
      
      private static const ALLY:String = "tank_small_platoon_squad";
      
      private static const DESTROYED_ALPHA:Number = 0.2;
       
      
      public var icon:BattleAtlasSprite = null;
      
      private var _platoonData:BattleRoyalePlatoonVO = null;
      
      public function BattleRoyalePlatoonRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         if(this._platoonData && this._platoonData.isDead)
         {
            alpha = DESTROYED_ALPHA;
            return;
         }
         this.cleanUpData();
         this._platoonData = new BattleRoyalePlatoonVO(param1);
         this.icon.imageName = !!this._platoonData.isEnemy ? ENEMY : ALLY;
         visible = !this._platoonData.isDefaultData;
         if(this._platoonData.isDead)
         {
            alpha = DESTROYED_ALPHA;
         }
      }
      
      override protected function onDispose() : void
      {
         this.cleanUpData();
         this.icon = null;
         this._platoonData = null;
         super.onDispose();
      }
      
      private function cleanUpData() : void
      {
         if(this._platoonData)
         {
            this._platoonData.dispose();
         }
      }
   }
}
