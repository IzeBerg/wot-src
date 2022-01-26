package net.wg.gui.lobby.techtree.data.state
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationProperties implements IDisposable
   {
       
      
      public var duration:Number;
      
      public var from:Object;
      
      public var to:Object;
      
      public function AnimationProperties(param1:Number, param2:Object, param3:Object)
      {
         super();
         this.duration = param1;
         this.from = param2;
         this.to = param3;
      }
      
      public function dispose() : void
      {
         if(this.from != null)
         {
            App.utils.data.cleanupDynamicObject(this.from);
            this.from = null;
         }
         if(this.to != null)
         {
            App.utils.data.cleanupDynamicObject(this.to);
            this.to = null;
         }
      }
      
      public function setFrom(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in this.from)
         {
            param1[_loc2_] = this.from[_loc2_];
         }
      }
      
      public function setTo(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in this.to)
         {
            param1[_loc2_] = this.to[_loc2_];
         }
      }
   }
}
