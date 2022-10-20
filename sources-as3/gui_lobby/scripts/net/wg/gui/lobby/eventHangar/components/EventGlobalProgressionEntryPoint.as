package net.wg.gui.lobby.eventHangar.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.eventHangar.data.EventGlobalProgressionVO;
   import net.wg.infrastructure.base.meta.IEventGlobalProgressionEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.EventGlobalProgressionEntryPointMeta;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   import scaleform.gfx.TextFieldEx;
   
   public class EventGlobalProgressionEntryPoint extends EventGlobalProgressionEntryPointMeta implements IEventGlobalProgressionEntryPointMeta, ISoundable
   {
      
      private static const SMALL_FRAME:int = 2;
      
      private static const DEFAULT_FRAME:int = 1;
       
      
      public var icon:MovieClip = null;
      
      public var background:MovieClip = null;
      
      public var textField:TextField = null;
      
      private var _data:EventGlobalProgressionVO = null;
      
      private var _isSmall:Boolean = false;
      
      private var _forceSmall:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      public function EventGlobalProgressionEntryPoint()
      {
         super();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return null;
      }
      
      public function getSoundType() : String
      {
         return null;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = buttonMode = true;
         mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.textField.text = EVENT.GLOBALPROGRESSION_LABEL;
         TextFieldEx.setVerticalAlign(this.textField,TextFieldEx.VALIGN_CENTER);
         this._toolTipMgr = App.toolTipMgr;
         if(App.soundMgr)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function onDispose() : void
      {
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         removeEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon = null;
         this.textField = null;
         this.background = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._isSmall || this._forceSmall;
            gotoAndStop(!!_loc1_ ? SMALL_FRAME : DEFAULT_FRAME);
            this.icon.gotoAndStop(!!_loc1_ ? SMALL_FRAME : DEFAULT_FRAME);
            this.textField.visible = !_loc1_;
            invalidateData();
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.background.gotoAndStop(this._data.phaseIndex);
         }
      }
      
      override protected function setData(param1:EventGlobalProgressionVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = param1 <= StageSizeBoundaries.WIDTH_1366;
         if(this._isSmall != _loc3_)
         {
            this._isSmall = _loc3_;
            invalidateSize();
         }
      }
      
      public function forceSmallSize(param1:Boolean) : void
      {
         if(this._forceSmall != param1)
         {
            this._forceSmall = param1;
            invalidateSize();
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data || StringUtils.isEmpty(this._data.tooltip))
         {
            return;
         }
         this._toolTipMgr.showComplex(this._data.tooltip);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onBtnClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            onClickS();
         }
      }
   }
}
