package net.wg.gui.components.common
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BaseLogoView extends MovieClip implements IDisposable
   {
       
      
      private var overrides:Array;
      
      public function BaseLogoView()
      {
         this.overrides = [];
         super();
         this.initOverrides();
      }
      
      public function setLocale(param1:String) : void
      {
         if(this.hasOverride(param1))
         {
            gotoAndStop(param1);
         }
      }
      
      public function hasOverride(param1:String) : Boolean
      {
         return Boolean(this.overrides.indexOf(param1) != -1);
      }
      
      private function initOverrides() : void
      {
         var _loc1_:FrameLabel = null;
         for each(_loc1_ in currentLabels)
         {
            this.overrides.push(_loc1_.name);
         }
      }
      
      public function dispose() : void
      {
         this.overrides.splice(0,this.overrides.length);
         this.overrides = null;
      }
   }
}
