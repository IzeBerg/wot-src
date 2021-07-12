package scaleform.clik.controls
{
   public class CheckBox extends Button
   {
       
      
      public function CheckBox()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _toggle = true;
      }
      
      override public function get autoRepeat() : Boolean
      {
         return false;
      }
      
      override public function set autoRepeat(param1:Boolean) : void
      {
      }
      
      override public function get toggle() : Boolean
      {
         return true;
      }
      
      override public function set toggle(param1:Boolean) : void
      {
      }
      
      override public function toString() : String
      {
         return "[CLIK CheckBox " + name + "]";
      }
   }
}
