package net.wg.gui.lobby.hangar.quests
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.ILiveOpsWebEventsEntryPointInjectMeta;
   import net.wg.infrastructure.base.meta.impl.LiveOpsWebEventsEntryPointInjectMeta;
   
   public class LiveOpsWebEventsEntryPoint extends LiveOpsWebEventsEntryPointInjectMeta implements ILiveOpsWebEventsEntryPointInjectMeta
   {
      
      private static const WIDTH:int = 48;
      
      private static const HEIGHT:int = 113;
      
      private static const WIDTH_BIG:int = 66;
      
      private static const HEIGHT_BIG:int = 113;
      
      private static const MARGIN:int = 1;
       
      
      private var _blink:MovieClip = null;
      
      public function LiveOpsWebEventsEntryPoint()
      {
         super();
         this._blink = App.utils.classFactory.getComponent("QuestButtonSwitchUI",MovieClip);
         this._blink.mouseEnabled = this._blink.mouseChildren = false;
         if(this._blink)
         {
            addChild(this._blink);
            this._blink.gotoAndPlay(1);
         }
      }
      
      override protected function onDispose() : void
      {
         this._blink.stop();
         this._blink = null;
         super.onDispose();
      }
      
      public function as_setIsSmall(param1:Boolean) : void
      {
         setSize((!!param1 ? WIDTH : WIDTH_BIG) + 2 * MARGIN,(!!param1 ? HEIGHT : HEIGHT_BIG) + 2 * MARGIN);
         this._blink.visible = param1;
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
