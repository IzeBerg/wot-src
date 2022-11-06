package net.wg.infrastructure.events
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class TutorialEvent extends Event
   {
      
      public static const VIEW_READY_FOR_TUTORIAL:String = "viewReadyForTutorial";
       
      
      public var pathPointNames:Vector.<String>;
      
      public var pathPointObjects:Vector.<DisplayObject>;
      
      public var unstoppable:Boolean = false;
      
      public var ev_target:DisplayObject = null;
      
      public function TutorialEvent(param1:String, param2:Boolean = false)
      {
         this.pathPointNames = new Vector.<String>();
         this.pathPointObjects = new Vector.<DisplayObject>();
         super(param1,true,false);
         this.unstoppable = param2;
      }
      
      override public function clone() : Event
      {
         var _loc1_:TutorialEvent = new TutorialEvent(type,this.unstoppable);
         _loc1_.pathPointNames = this.pathPointNames.concat();
         _loc1_.pathPointObjects = this.pathPointObjects.concat();
         _loc1_.ev_target = DisplayObject(target);
         return _loc1_;
      }
      
      public function addPathPoint(param1:DisplayObject, param2:String) : void
      {
         this.pathPointNames.unshift(param2);
         this.pathPointObjects.unshift(param1);
      }
   }
}
