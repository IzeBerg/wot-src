package net.wg.gui.battle.views.battleTankCarousel.renderers
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BaseBattleTankIcon extends BattleUIComponent
   {
      
      private static const REGULAR_TYPE_POS_X:int = 3;
      
      private static const REGULAR_TYPE_POS_Y:int = 3;
      
      private static const REGULAR_LEVEL_POS_X:int = 15;
      
      private static const ELITE_TYPE_POS_X:int = 0;
      
      private static const ELITE_TYPE_POS_Y:int = -3;
      
      private static const ELITE_LEVEL_POS_X:int = 19;
      
      private static const PREM_FILTER:DropShadowFilter = new DropShadowFilter(0,90,16723968,0.7,12,12,3,2);
      
      private static const DEF_FILTER:DropShadowFilter = new DropShadowFilter(0,90,13224374,0.2,8,8,4,2);
       
      
      public var flagLoader:UILoaderAlt = null;
      
      public var tankIcon:UILoaderAlt = null;
      
      public var tankType:UILoaderAlt = null;
      
      public var tankLevel:UILoaderAlt = null;
      
      public var imgFavorite:UILoaderAlt = null;
      
      public var tankNameTF:TextField = null;
      
      public var cooldownTimeTF:TextField = null;
      
      public var emptySlotBg:Sprite = null;
      
      public var lockedBG:Sprite = null;
      
      private var _visibleVehicleInfo:Boolean = true;
      
      private var _isLocked:Boolean = false;
      
      private var _coolDownText:String = "";
      
      public function BaseBattleTankIcon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.flagLoader.dispose();
         this.flagLoader = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.tankType.dispose();
         this.tankType = null;
         this.tankLevel.dispose();
         this.imgFavorite.dispose();
         this.imgFavorite = null;
         this.tankLevel = null;
         this.tankNameTF = null;
         this.cooldownTimeTF = null;
         this.emptySlotBg = null;
         this.lockedBG = null;
         super.onDispose();
      }
      
      public final function setData(param1:BattleVehicleCarouselVO) : void
      {
         if(param1 != null)
         {
            this.updateData(param1);
            this.emptySlotBg.visible = false;
         }
         else
         {
            this.setVisibleVehicleInfo(false);
            this.imgFavorite.visible = false;
            this.emptySlotBg.visible = true;
         }
      }
      
      protected function updateData(param1:BattleVehicleCarouselVO) : void
      {
         this.lockedBG.visible = false;
         this.tankNameTF.htmlText = param1.vehicleName;
         this.tankNameTF.filters = !!param1.isPremium ? [PREM_FILTER] : [DEF_FILTER];
         this.flagLoader.source = param1.flagIcon;
         this.tankIcon.source = param1.vehicleIcon;
         this.tankLevel.source = param1.vehicleLevelIcon;
         this.tankType.source = param1.vehicleTypeIcon;
         this.tankType.x = !!param1.isElite ? Number(ELITE_TYPE_POS_X) : Number(REGULAR_TYPE_POS_X);
         this.tankType.y = !!param1.isElite ? Number(ELITE_TYPE_POS_Y) : Number(REGULAR_TYPE_POS_Y);
         this.tankLevel.x = !!param1.isElite ? Number(ELITE_LEVEL_POS_X) : Number(REGULAR_LEVEL_POS_X);
         this._isLocked = !param1.enabled;
         this._coolDownText = param1.cooldown;
         this.setVisibleVehicleInfo(true);
         this.updateLockBg();
         this.imgFavorite.visible = param1.favorite;
         if(param1.favorite)
         {
            this.imgFavorite.source = RES_ICONS.MAPS_ICONS_TOOLTIP_MAIN_TYPE;
         }
         visible = true;
      }
      
      protected function setVisibleVehicleInfo(param1:Boolean) : void
      {
         if(this._visibleVehicleInfo != param1)
         {
            this._visibleVehicleInfo = param1;
            this.tankNameTF.visible = this.flagLoader.visible = this.tankIcon.visible = this.tankLevel.visible = this.tankType.visible = param1;
         }
         var _loc2_:Boolean = this._isLocked && StringUtils.isNotEmpty(this._coolDownText);
         this.cooldownTimeTF.visible = _loc2_ && param1;
         if(_loc2_)
         {
            this.cooldownTimeTF.text = this._coolDownText;
         }
      }
      
      private function updateLockBg() : void
      {
         this.lockedBG.visible = this._isLocked || !enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.updateLockBg();
      }
   }
}
