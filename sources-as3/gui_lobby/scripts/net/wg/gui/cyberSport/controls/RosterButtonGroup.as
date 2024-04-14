package net.wg.gui.cyberSport.controls
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   
   public class RosterButtonGroup extends ButtonGroup
   {
       
      
      protected var olderSelectedButton:Button;
      
      public function RosterButtonGroup(param1:String, param2:DisplayObjectContainer)
      {
         super(param1,param2);
      }
      
      public static function getGroup(param1:String, param2:DisplayObjectContainer) : RosterButtonGroup
      {
         var _loc3_:Object = groups[param2];
         if(_loc3_ == null)
         {
            _loc3_ = groups[param2] = new Object();
         }
         var _loc4_:RosterButtonGroup = _loc3_[App.utils.toUpperOrLowerCase(param1,false)];
         if(_loc4_ == null)
         {
            _loc4_ = _loc3_[App.utils.toUpperOrLowerCase(param1,false)] = new RosterButtonGroup(param1,param2);
         }
         return _loc4_;
      }
      
      override protected function updateSelectedButton(param1:Button, param2:Boolean = true) : void
      {
         if(param2 && param1 == selectedButton)
         {
            return;
         }
         var _loc3_:Boolean = !param2 && param1 == selectedButton && param1.allowDeselect;
         var _loc4_:Boolean = !param2 && param1 == this.olderSelectedButton && param1.allowDeselect;
         var _loc5_:Button = this.olderSelectedButton;
         var _loc6_:Button = selectedButton;
         if(param2)
         {
            if(_loc6_)
            {
               this.olderSelectedButton = _loc6_;
            }
            selectedButton = param1;
         }
         if(param2 && _loc5_ != null)
         {
            _loc5_.selected = false;
         }
         if(_loc3_)
         {
            selectedButton = null;
         }
         else if(_loc4_)
         {
            this.olderSelectedButton = null;
         }
         else if(!param2)
         {
            return;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get rangeData() : Array
      {
         var _loc1_:Array = [];
         if(selectedButton)
         {
            _loc1_.push(selectedButton.data);
         }
         if(this.olderSelectedButton)
         {
            _loc1_.push(this.olderSelectedButton.data);
         }
         return _loc1_;
      }
   }
}
