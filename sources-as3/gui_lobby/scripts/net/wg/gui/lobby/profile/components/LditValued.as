package net.wg.gui.lobby.profile.components
{
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.components.advanced.LineDescrIconText;
   
   public class LditValued extends LineDescrIconText
   {
       
      
      private var _value:String;
      
      public function LditValued()
      {
         super();
      }
      
      override protected function showToolTip(param1:IToolTipParams) : void
      {
         var _loc2_:Object = null;
         if(tooltip)
         {
            if(this._value)
            {
               _loc2_ = {"value_0":"<font face=\'$TitleFont\'>" + this._value + "</font>"};
            }
            App.toolTipMgr.showComplexWithParams(tooltip,new ToolTipParams({},_loc2_));
         }
      }
      
      public function set value(param1:*) : void
      {
         this._value = param1;
      }
   }
}
