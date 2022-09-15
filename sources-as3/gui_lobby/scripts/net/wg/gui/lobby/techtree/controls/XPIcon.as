package net.wg.gui.lobby.techtree.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class XPIcon extends UIComponentEx
   {
       
      
      private var _type:String = null;
      
      public function XPIcon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         mouseEnabled = mouseChildren = focusable = false;
         super.configUI();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateIcon();
         }
         super.draw();
      }
      
      private function updateIcon() : void
      {
         if(this._type != currentFrameLabel && _labelHash[this._type])
         {
            gotoAndStop(this._type);
         }
      }
      
      [Inspectable(defaultValue="earned",enumeration="earned,elite,cost,free,action")]
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         if(this._type != currentFrameLabel)
         {
            invalidateData();
         }
      }
   }
}
