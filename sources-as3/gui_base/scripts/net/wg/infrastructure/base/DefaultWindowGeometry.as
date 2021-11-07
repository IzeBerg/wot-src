package net.wg.infrastructure.base
{
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.IWindowGeometry;
   
   public class DefaultWindowGeometry implements IWindowGeometry
   {
      
      public static const POSITION_ONCE:String = "once";
      
      public static const POSITION_ALWAYS:String = "always";
       
      
      private var _positionStrategy:String = "once";
      
      private var _doPositionOnce:Boolean = true;
      
      private var _doRepositionYOnce:Boolean = true;
      
      private var _minY:int = 0;
      
      public function DefaultWindowGeometry(param1:int = 0)
      {
         super();
         this._minY = param1;
      }
      
      public function canOverwrite() : Boolean
      {
         return true;
      }
      
      public function setSize(param1:IWindow) : Boolean
      {
         param1.updateSize(param1.getMinWidth(),param1.getMinHeight());
         if(this._doRepositionYOnce && param1.y + param1.height > App.appHeight)
         {
            param1.y = Math.max(Math.round(App.appHeight - param1.height >> 1),this._minY);
            this._doRepositionYOnce = false;
         }
         return true;
      }
      
      public function setPosition(param1:IWindow) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:IAbstractWindowView = param1.windowContent;
         if(_loc2_ && _loc2_.isCentered)
         {
            _loc3_ = Math.round(App.appWidth - param1.width >> 1);
            _loc4_ = Math.max(Math.round(App.appHeight - param1.height >> 1),this._minY);
            if(_loc2_.isModal || this._positionStrategy == POSITION_ALWAYS)
            {
               param1.x = _loc3_;
               param1.y = _loc4_;
            }
            else if(this._doPositionOnce)
            {
               param1.x += _loc3_;
               param1.y += _loc4_;
               this._doPositionOnce = false;
            }
         }
         return true;
      }
      
      public function get positionStrategy() : String
      {
         return this._positionStrategy;
      }
      
      public function set positionStrategy(param1:String) : void
      {
         this._positionStrategy = param1;
      }
   }
}
