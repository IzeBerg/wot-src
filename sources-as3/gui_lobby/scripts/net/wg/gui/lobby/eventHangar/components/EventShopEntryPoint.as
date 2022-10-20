package net.wg.gui.lobby.eventHangar.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.eventHangar.data.EventShopEntryPointVO;
   import net.wg.infrastructure.base.meta.IEventShopEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.EventShopEntryPointMeta;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class EventShopEntryPoint extends EventShopEntryPointMeta implements IEventShopEntryPointMeta
   {
       
      
      public var hit:Sprite = null;
      
      public var kettleType:MovieClip = null;
      
      public var titleTF:TextField = null;
      
      private var _data:EventShopEntryPointVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _soundMgr:ISoundManager = null;
      
      public function EventShopEntryPoint()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hit.addEventListener(MouseEvent.CLICK,this.onHitClickHandler);
         this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onHitOverHandler);
         this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onHitOutHandler);
         this.hit.buttonMode = this.hit.useHandCursor = true;
         this._toolTipMgr = App.toolTipMgr;
         this._soundMgr = App.soundMgr;
      }
      
      override protected function onDispose() : void
      {
         this.hit.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler);
         this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onHitOverHandler);
         this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onHitOutHandler);
         this.hit = null;
         this.kettleType = null;
         this.titleTF = null;
         this._data = null;
         this._toolTipMgr = null;
         this._soundMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.kettleType.gotoAndStop(this._data.kettleType);
            if(_baseDisposed)
            {
               return;
            }
            this.titleTF.text = this._data.title;
         }
      }
      
      override protected function setData(param1:EventShopEntryPointVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return this.hit.width;
      }
      
      override public function get height() : Number
      {
         return this.hit.height;
      }
      
      public function setState(param1:String) : void
      {
         gotoAndStop(param1);
         if(_baseDisposed)
         {
            return;
         }
         invalidateData();
      }
      
      private function onHitClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
            onClickS();
         }
      }
      
      private function onHitOverHandler(param1:MouseEvent) : void
      {
         this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
         if(!this._data)
         {
            return;
         }
         this._toolTipMgr.showComplex(this._data.tooltip);
      }
      
      private function onHitOutHandler(param1:MouseEvent) : void
      {
         this._soundMgr.playControlsSnd(SoundManagerStates.SND_OUT,SoundTypes.NORMAL_BTN,null);
         this._toolTipMgr.hide();
      }
   }
}
