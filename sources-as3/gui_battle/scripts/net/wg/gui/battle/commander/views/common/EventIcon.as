package net.wg.gui.battle.commander.views.common
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   
   public class EventIcon extends BaseIcon
   {
       
      
      public var bgLine:MovieClip = null;
      
      private var _bgWidth:Number = 160;
      
      private var _currentCondition:String = "NoCondition";
      
      public function EventIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bgLine = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.bgLine != null)
            {
               this.bgLine.width = this._bgWidth;
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            gotoAndStop(this._currentCondition);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(!isShown)
            {
               visible = false;
            }
         }
      }
      
      override public function get width() : Number
      {
         return this._bgWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._bgWidth != param1)
         {
            this._bgWidth = param1;
            invalidateSize();
         }
      }
      
      public function setCondition(param1:String) : void
      {
         if(this._currentCondition != param1)
         {
            this._currentCondition = param1;
            invalidate(InvalidationType.STATE);
         }
      }
   }
}
