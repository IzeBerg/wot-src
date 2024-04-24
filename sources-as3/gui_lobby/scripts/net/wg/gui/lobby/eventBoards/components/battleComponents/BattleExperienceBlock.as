package net.wg.gui.lobby.eventBoards.components.battleComponents
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.lobby.eventBoards.data.BattleExperienceBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleExperienceBlock extends UIComponentEx
   {
      
      private static const TOOLTIP_MAX_WIDTH:int = 400;
       
      
      public var experienceIcon:IImage = null;
      
      public var experienceValueTf:TextField = null;
      
      public var experienceTf:TextField = null;
      
      public var ribbon:MovieClip = null;
      
      public var positionTf:TextField = null;
      
      public var battleIcon:IImage = null;
      
      public var battleValueTf:TextField = null;
      
      public var battleTf:TextField = null;
      
      private var _data:BattleExperienceBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function BattleExperienceBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.experienceValueTf.htmlText = App.utils.locale.integer(this._data.experienceValue);
            this.experienceTf.htmlText = this._data.experience;
            this.positionTf.htmlText = this._data.position;
            this.battleValueTf.htmlText = App.utils.locale.integer(this._data.battleValue);
            this.battleTf.htmlText = this._data.battle;
            this.experienceIcon.visible = StringUtils.isNotEmpty(this._data.experienceIcon);
            if(this.experienceIcon.visible)
            {
               this.experienceIcon.source = this._data.experienceIcon;
            }
            this.battleIcon.visible = StringUtils.isNotEmpty(this._data.battleIcon);
            if(this.battleIcon.visible)
            {
               this.battleIcon.source = this._data.battleIcon;
            }
            this.ribbon.gotoAndStop(this._data.ribbon);
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.experienceValueTf = null;
         this.experienceTf = null;
         this.positionTf = null;
         this.battleValueTf = null;
         this.battleTf = null;
         this.experienceIcon.dispose();
         this.experienceIcon = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.ribbon = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = BattleExperienceBlockVO(param1);
            invalidateData();
         }
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data)
         {
            return;
         }
         var _loc2_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,TOOLTIP_MAX_WIDTH);
         var _loc3_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.experienceIcon:
            case this.experienceValueTf:
            case this.experienceTf:
               _loc3_ = this._data.experienceTooltip;
               break;
            case this.ribbon:
            case this.positionTf:
               _loc3_ = this._data.positionTooltip;
               break;
            case this.battleIcon:
            case this.battleValueTf:
            case this.battleTf:
               _loc3_ = this._data.battleTooltip;
               break;
            default:
               return;
         }
         this._toolTipMgr.showComplex(_loc3_,_loc2_);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
