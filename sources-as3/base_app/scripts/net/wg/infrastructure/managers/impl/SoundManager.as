package net.wg.infrastructure.managers.impl
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.infrastructure.base.meta.impl.SoundManagerMeta;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   import scaleform.clik.events.ButtonEvent;
   
   public class SoundManager extends SoundManagerMeta implements ISoundManager
   {
       
      
      private var _mouseToSoundEvents:Object;
      
      public function SoundManager()
      {
         super();
      }
      
      public function playControlsSnd(param1:String, param2:String, param3:String) : void
      {
         soundEventHandlerS("controls",param1,param2,param3);
      }
      
      public function addSoundsHdlrs(param1:ISoundable) : void
      {
         assertNotNull(param1,"container");
         this.subscribeObject(param1);
      }
      
      public function removeSoundHdlrs(param1:ISoundable) : void
      {
         assertNotNull(param1,"container");
         this.unsubscribeObject(param1);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._mouseToSoundEvents = {};
         this._mouseToSoundEvents[MouseEvent.ROLL_OVER] = SoundManagerStates.SND_OVER;
         this._mouseToSoundEvents[MouseEvent.ROLL_OUT] = SoundManagerStates.SND_OUT;
         this._mouseToSoundEvents[MouseEvent.MOUSE_DOWN] = SoundManagerStates.SND_PRESS;
      }
      
      override protected function onDispose() : void
      {
         this._mouseToSoundEvents = null;
         super.onDispose();
      }
      
      private function subscribeObject(param1:ISoundable) : void
      {
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onMouseHandler);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onMouseHandler);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseHandler);
      }
      
      private function unsubscribeObject(param1:ISoundable) : void
      {
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseHandler);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseHandler);
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseHandler);
      }
      
      private function onMouseHandler(param1:Event) : void
      {
         if(param1 is ButtonEvent)
         {
            if(ButtonEvent(param1).buttonIdx > 0)
            {
               return;
            }
         }
         var _loc2_:ISoundable = ISoundable(param1.currentTarget);
         if(_loc2_.canPlaySound(param1.type))
         {
            this.playControlsSnd(this._mouseToSoundEvents[param1.type],_loc2_.getSoundType(),_loc2_.getSoundId());
         }
      }
   }
}
