package net.wg.gui.bootcamp.introVideoPage.containers
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.bootcamp.introVideoPage.data.RewardRendererVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.uilogger.bootcamp.events.TooltipLogEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class IntroRewardRenderer extends UIComponentEx implements IUpdatable
   {
       
      
      public var icon:UILoaderAlt = null;
      
      public var rewardName:TextField = null;
      
      private var _data:RewardRendererVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function IntroRewardRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this.rewardName.text = this._data.label;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.dispose();
         this.icon = null;
         this.rewardName = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = RewardRendererVO(param1);
         invalidateData();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data)
         {
            if(this._data.isSpecial)
            {
               this._toolTipMgr.showSpecial.apply(this,[this._data.specialAlias,null].concat(this._data.specialArgs));
            }
            else
            {
               this._toolTipMgr.showComplex(this._data.tooltip);
            }
            dispatchEvent(new TooltipLogEvent(TooltipLogEvent.SHOW_TOOLTIP,this._data.label,true));
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         dispatchEvent(new TooltipLogEvent(TooltipLogEvent.HIDE_TOOLTIP,this._data.label,true));
      }
   }
}
