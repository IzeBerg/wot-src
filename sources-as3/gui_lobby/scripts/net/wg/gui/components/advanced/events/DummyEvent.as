package net.wg.gui.components.advanced.events
{
   import flash.events.Event;
   import net.wg.gui.components.advanced.vo.DummyVO;
   
   public class DummyEvent extends Event
   {
      
      public static const CLICK:String = "linkOrButtonClick";
      
      public static const SHOW_DUMMY:String = "showDummy";
      
      public static const HIDE_DUMMY:String = "hideDummy";
       
      
      public var clickType:String;
      
      private var _data:DummyVO;
      
      public function DummyEvent(param1:String)
      {
         super(param1,true,true);
      }
      
      public function get data() : DummyVO
      {
         return this._data;
      }
      
      public function set data(param1:DummyVO) : void
      {
         this._data = param1;
      }
   }
}
