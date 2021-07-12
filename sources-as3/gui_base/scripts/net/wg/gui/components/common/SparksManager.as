package net.wg.gui.components.common
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.interfaces.ISparksManager;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public final class SparksManager implements ISparksManager
   {
      
      private static const SPARK_NAME:String = "spark_";
       
      
      private var _sparkQuantity:Number = 0;
      
      private var _scope:Sprite = null;
      
      private var _zone:Rectangle = null;
      
      public function SparksManager()
      {
         super();
      }
      
      public function createSparks() : void
      {
         var _loc2_:Spark = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._sparkQuantity)
         {
            _loc2_ = App.utils.classFactory.getComponent("SparkUI",Spark);
            _loc2_.init(this._zone,SPARK_NAME + _loc1_);
            this._scope.addChild(_loc2_);
            _loc2_.startAnimation();
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:IDisposable = null;
         while(this._scope.numChildren)
         {
            _loc1_ = IDisposable(this._scope.getChildAt(0));
            _loc1_.dispose();
            this._scope.removeChildAt(0);
         }
         this._scope = null;
      }
      
      public function resetZone(param1:Rectangle) : void
      {
         var _loc4_:Spark = null;
         this._zone = param1;
         var _loc2_:int = this._scope.numChildren;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._scope.getChildAt(_loc3_) as Spark;
            App.utils.asserter.assertNotNull(_loc4_,"spark" + Errors.CANT_NULL);
            _loc4_.zone = this._zone;
            _loc3_++;
         }
      }
      
      public function get scope() : Sprite
      {
         return this._scope;
      }
      
      public function set scope(param1:Sprite) : void
      {
         this._scope = param1;
      }
      
      public function get sparkQuantity() : Number
      {
         return this._sparkQuantity;
      }
      
      public function set sparkQuantity(param1:Number) : void
      {
         this._sparkQuantity = param1;
      }
      
      public function get zone() : Rectangle
      {
         return this._zone;
      }
      
      public function set zone(param1:Rectangle) : void
      {
         this._zone = param1;
      }
   }
}
