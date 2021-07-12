package net.wg.infrastructure.base
{
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.IWindowGeometry;
   
   public class StoredWindowGeometry implements IWindowGeometry
   {
       
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var doPositionOnce:Boolean;
      
      public function StoredWindowGeometry(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this._x = param1;
         this._y = param2;
         this._width = param3;
         this._height = param4;
         this.doPositionOnce = false;
      }
      
      public function canOverwrite() : Boolean
      {
         return false;
      }
      
      public function setSize(param1:IWindow) : Boolean
      {
         if(this._width > 0 && this._height > 0)
         {
            param1.updateSize(this._width,this._height);
         }
         else
         {
            param1.updateSize(param1.getMinWidth(),param1.getMinHeight());
         }
         return true;
      }
      
      public function setPosition(param1:IWindow) : Boolean
      {
         var _loc2_:Boolean = false;
         if(!this.doPositionOnce && param1)
         {
            param1.x = this._x;
            param1.y = this._y;
            this.doPositionOnce = true;
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function get positionStrategy() : String
      {
         return "";
      }
      
      public function set positionStrategy(param1:String) : void
      {
      }
   }
}
