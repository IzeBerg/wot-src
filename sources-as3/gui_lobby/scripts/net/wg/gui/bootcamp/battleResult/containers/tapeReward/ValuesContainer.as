package net.wg.gui.bootcamp.battleResult.containers.tapeReward
{
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.battleResult.containers.base.BaseRendererContainer;
   import net.wg.gui.bootcamp.battleResult.data.BattleItemRendererVO;
   import net.wg.gui.bootcamp.battleResult.data.RewardDataVO;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   
   public class ValuesContainer extends UIComponentEx implements IDisposable
   {
      
      private static const RENDERER_COUNT:int = 2;
      
      private static const MARGIN_X:int = 36;
       
      
      public var exp:BaseRendererContainer = null;
      
      public var silver:BaseRendererContainer = null;
      
      private var _expData:BattleItemRendererVO = null;
      
      private var _silverData:BattleItemRendererVO = null;
      
      private var _rendererLoaded:int = 0;
      
      private var _expValue:String = "";
      
      private var _silverValue:String = "";
      
      public function ValuesContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(BattleViewEvent.RENDERER_LOADED,this.onRendererLoadedHandler);
         this._silverData = new BattleItemRendererVO({
            "icon":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_BRCREDITS,
            "label":TOOLTIPS.CREDITS_HEADER,
            "description":BOOTCAMP.MESSAGE_CREDITS_TEXT,
            "iconTooltip":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_TOOLTIPS_BCCREDITS
         });
         this._expData = new BattleItemRendererVO({
            "icon":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_BREXP,
            "label":TOOLTIPS.XP_HEADER,
            "description":BOOTCAMP.MESSAGE_EXPERIENCE_TEXT,
            "iconTooltip":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_TOOLTIPS_BCEXP
         });
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(BattleViewEvent.RENDERER_LOADED,this.onRendererLoadedHandler);
         this.exp.dispose();
         this.exp = null;
         this.silver.dispose();
         this.silver = null;
         this._silverData.dispose();
         this._silverData = null;
         this._expData.dispose();
         this._expData = null;
         this._rendererLoaded = 0;
         this._expValue = null;
         this._silverValue = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateLayout();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.validateDate();
         }
      }
      
      public function setAwardValues(param1:RewardDataVO, param2:RewardDataVO) : void
      {
         this._expValue = param2.str;
         this._silverValue = param1.str;
         invalidateData();
      }
      
      private function validateDate() : void
      {
         this._expData.value = this._expValue;
         this._silverData.value = this._silverValue;
         this.exp.update(this._expData);
         this.silver.update(this._silverData);
         invalidateLayout();
      }
      
      private function validateLayout() : void
      {
         this.silver.x = this.exp.actualWidth + MARGIN_X >> 0;
      }
      
      private function onRendererLoadedHandler(param1:BattleViewEvent) : void
      {
         ++this._rendererLoaded;
         if(this._rendererLoaded >= RENDERER_COUNT)
         {
            this.validateLayout();
            dispatchEvent(new BattleViewEvent(BattleViewEvent.ALL_RENDERERS_LOADED,Values.EMPTY_STR));
            this.exp.showAnimation();
            this.silver.showAnimation();
         }
      }
   }
}
