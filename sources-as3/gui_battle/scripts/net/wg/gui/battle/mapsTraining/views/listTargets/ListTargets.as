package net.wg.gui.battle.mapsTraining.views.listTargets
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ListTargets extends Sprite implements IDisposable
   {
       
      
      private var _items:Vector.<MovieClip>;
      
      public const TARGET_LINKAGE:String = "TargetItemUI";
      
      public const TARGET_GAP:int = 40;
      
      public function ListTargets()
      {
         this._items = new Vector.<MovieClip>();
         super();
      }
      
      public final function dispose() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._items)
         {
            removeChild(_loc1_);
         }
         this._items.splice(0,this._items.length);
         this._items = null;
      }
      
      public function setGoals(param1:Vector.<MapsTrainingGoalVO>) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MapsTrainingGoalVO = null;
         var _loc4_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.total)
            {
               _loc2_ = App.utils.classFactory.getObject(this.TARGET_LINKAGE) as MovieClip;
               _loc2_.x = this.TARGET_GAP * this._items.length;
               _loc2_.gotoAndStop(_loc3_.vehClass);
               addChild(_loc2_);
               this._items.push(_loc2_);
               _loc4_++;
            }
         }
      }
      
      public function getWidth() : int
      {
         return Boolean(this._items.length) ? int(this.TARGET_GAP * (this._items.length - 1)) : int(0);
      }
   }
}
