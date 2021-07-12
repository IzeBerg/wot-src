package net.wg.gui.lobby.hangar.seniorityAwards
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
   import net.wg.infrastructure.base.meta.ISeniorityAwardsEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.SeniorityAwardsEntryPointMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class SeniorityAwardsEntryPoint extends SeniorityAwardsEntryPointMeta implements ISeniorityAwardsEntryPointMeta
   {
      
      private static const DESCRIPTION_BREAKPOINT:int = 21;
      
      private static const BTN_TOP_MARGIN:int = 12;
       
      
      public var counterTF:TextField = null;
      
      public var descrTF:TextField = null;
      
      public var multiplierTF:TextField = null;
      
      public var openBtn:ISoundButtonEx = null;
      
      public var bounds:MovieClip = null;
      
      private var _data:SeniorityAwardsEntryPointVO = null;
      
      public function SeniorityAwardsEntryPoint()
      {
         super();
         visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.openBtn.soundType = SoundTypes.OK_BTN;
         this.openBtn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.counterTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function setData(param1:SeniorityAwardsEntryPointVO) : void
      {
         this._data = param1;
         this.applyData();
         this.updatePosition();
      }
      
      override protected function onDispose() : void
      {
         this.openBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.openBtn.dispose();
         this.openBtn = null;
         this.counterTF = null;
         this.descrTF = null;
         this.multiplierTF = null;
         this.bounds = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setDataVO(param1:SeniorityAwardsEntryPointVO) : void
      {
         this.setData(param1);
      }
      
      protected function applyData() : void
      {
         if(this._data)
         {
            this.counterTF.text = this._data.count;
            this.descrTF.text = this._data.descr;
            this.multiplierTF.text = this._data.multiplier;
            this.openBtn.label = this._data.btnLabel;
            this.openBtn.validateNow();
         }
         visible = this._data != null;
      }
      
      protected function updatePosition() : void
      {
         var _loc1_:int = this.counterTF.textWidth + this.multiplierTF.textWidth;
         var _loc2_:int = this.descrTF.x + (this.descrTF.width >> 1);
         var _loc3_:int = _loc2_ - (_loc1_ >> 1);
         this.multiplierTF.x = _loc3_;
         this.counterTF.x = _loc3_ + this.multiplierTF.textWidth;
         this.openBtn.x = this.descrTF.x + (this.descrTF.width - this.openBtn.actualWidth >> 1);
         var _loc4_:int = this.descrTF.textHeight;
         var _loc5_:int = _loc4_ > DESCRIPTION_BREAKPOINT ? int(BTN_TOP_MARGIN >> 1) : int(BTN_TOP_MARGIN);
         this.openBtn.y = this.descrTF.y + _loc4_ + _loc5_;
         dispatchEvent(new Event(Event.RESIZE,true,true));
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         if(isDAAPIInited)
         {
            onClickS();
         }
         else
         {
            dispatchEvent(new Event(ProgressiveRewardEvent.OPEN_BTN_CLICK,true));
         }
      }
   }
}
