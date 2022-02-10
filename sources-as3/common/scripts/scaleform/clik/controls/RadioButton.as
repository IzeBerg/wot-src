package scaleform.clik.controls
{
   public class RadioButton extends Button
   {
      
      public static const DEFAULT_GROUPNAME:String = "default";
       
      
      public function RadioButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.toggle = true;
         allowDeselect = false;
         if(_group == null)
         {
            this.groupName = DEFAULT_GROUPNAME;
         }
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
      
      [Inspectable(defaultValue="")]
      override public function get groupName() : String
      {
         return super.groupName;
      }
      
      override public function set groupName(param1:String) : void
      {
         super.groupName = param1;
      }
      
      override public function toString() : String
      {
         return "[CLIK RadioButton " + name + "]";
      }
   }
}
