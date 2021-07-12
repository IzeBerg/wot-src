package net.wg.gui.components.tooltips.helpers
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TankTypeIco extends UIComponentEx
   {
       
      
      private var _type:String = null;
      
      public function TankTypeIco()
      {
         super();
         stop();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         gotoAndStop(1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_labelHash[this.type])
         {
            gotoAndStop(this.type);
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
         invalidate();
      }
   }
}
