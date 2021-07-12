package net.wg.gui.components.common
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class FrameStateCmpnt extends UIComponentEx
   {
       
      
      private var _curLabel:String = "";
      
      private var _allowResize:Boolean = false;
      
      public function FrameStateCmpnt()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG FrameStateCmpnt " + name + "]";
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._allowResize)
            {
               setActualSize(_width,_height);
            }
            else
            {
               setActualSize(actualWidth,actualHeight);
            }
         }
      }
      
      public function set frameLabel(param1:String) : void
      {
         if(_labelHash[param1])
         {
            if(this._curLabel == param1)
            {
               return;
            }
            this._curLabel = param1;
            gotoAndStop(param1);
            if(this._allowResize)
            {
               invalidateSize();
            }
         }
         else
         {
            DebugUtils.LOG_WARNING("Label \"" + param1 + "\" for " + this + " doesn\'t exist");
         }
      }
      
      public function set allowResize(param1:Boolean) : void
      {
         this._allowResize = param1;
         invalidateSize();
      }
   }
}
