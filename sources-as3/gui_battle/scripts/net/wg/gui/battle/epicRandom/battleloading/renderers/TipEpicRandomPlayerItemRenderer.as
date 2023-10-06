package net.wg.gui.battle.epicRandom.battleloading.renderers
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   
   public class TipEpicRandomPlayerItemRenderer extends EpicRandomBasePlayerItemRenderer implements IStageSizeDependComponent
   {
      
      private static const PRESTIGE_LEVEL_SHIFT_X:int = 30;
       
      
      private var _defaultVehicleTypeIconXPosition:int;
      
      private var _defaultBadgeXPosition:int;
      
      private var _defaultSelfBgXPosition:int;
      
      private var _defaultSquadXPosition:int;
      
      public function TipEpicRandomPlayerItemRenderer()
      {
         super();
         this._defaultVehicleTypeIconXPosition = vehicleTypeIcon.x;
         this._defaultBadgeXPosition = rankBadge.x;
         this._defaultSelfBgXPosition = selfBg.x;
         this._defaultSquadXPosition = squad.x;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         prestigeLevel.visible = false;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         super.onDispose();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 >= StageSizeBoundaries.WIDTH_1366;
         if(_loc3_ == prestigeLevel.visible)
         {
            return;
         }
         prestigeLevel.visible = _loc3_;
         invalidateLayout();
      }
      
      override protected function setSelfBG() : void
      {
         super.setSelfBG();
         if(selfBg != null && selfBg.visible)
         {
            selfBg.imageName = !!prestigeLevel.visible ? BATTLEATLAS.EPIC_RANDOM_BATTLE_LOADING_SELF_TIPS_EXTENDED_BACKGROUND : BATTLEATLAS.EPIC_RANDOM_BATTLE_LOADING_SELF_TIPS_BACKGROUND;
         }
      }
      
      override protected function updateLayout() : void
      {
         vehicleTypeIcon.x = this._defaultVehicleTypeIconXPosition;
         rankBadge.x = this._defaultBadgeXPosition;
         selfBg.x = this._defaultSelfBgXPosition;
         squad.x = this._defaultSquadXPosition;
         super.updateLayout();
         if(prestigeLevel.visible)
         {
            if(isEnemy)
            {
               textField.x += PRESTIGE_LEVEL_SHIFT_X;
               rankBadge.x += PRESTIGE_LEVEL_SHIFT_X;
               vehicleField.x += PRESTIGE_LEVEL_SHIFT_X;
               vehicleTypeIcon.x += PRESTIGE_LEVEL_SHIFT_X;
               testerIcon.x += PRESTIGE_LEVEL_SHIFT_X;
               testerBG.x += PRESTIGE_LEVEL_SHIFT_X;
               icoIGR.x += PRESTIGE_LEVEL_SHIFT_X;
               selfBg.x += PRESTIGE_LEVEL_SHIFT_X;
               squad.x += PRESTIGE_LEVEL_SHIFT_X;
            }
            else
            {
               textField.x -= PRESTIGE_LEVEL_SHIFT_X;
               rankBadge.x -= PRESTIGE_LEVEL_SHIFT_X;
               vehicleField.x -= PRESTIGE_LEVEL_SHIFT_X;
               vehicleTypeIcon.x -= PRESTIGE_LEVEL_SHIFT_X;
               testerIcon.x -= PRESTIGE_LEVEL_SHIFT_X;
               testerBG.x -= PRESTIGE_LEVEL_SHIFT_X;
               icoIGR.x -= PRESTIGE_LEVEL_SHIFT_X;
               selfBg.x -= PRESTIGE_LEVEL_SHIFT_X;
               squad.x -= PRESTIGE_LEVEL_SHIFT_X;
            }
         }
      }
   }
}
