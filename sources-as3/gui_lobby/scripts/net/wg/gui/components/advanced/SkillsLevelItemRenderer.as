package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SkillsLevelItemRenderer extends MovieClip implements IDisposable
   {
       
      
      public var rankTf:TextField;
      
      private var _disposed:Boolean = false;
      
      public function SkillsLevelItemRenderer()
      {
         super();
      }
      
      private static function getRankGlowFilter() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Number = 16724246;
         var _loc3_:Number = 0.5;
         var _loc4_:Number = 6;
         var _loc5_:Number = 6;
         var _loc6_:Number = 4;
         var _loc7_:Number = 3;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:GlowFilter = new GlowFilter(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         _loc1_.push(_loc10_);
         return _loc1_;
      }
      
      public function updateText(param1:int) : void
      {
         this.rankTf.text = param1.toString();
         this.rankTf.filters = null;
         this.rankTf.filters = getRankGlowFilter();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.rankTf = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
