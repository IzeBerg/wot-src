package net.wg.gui.components.questProgress.interfaces.components
{
   import flash.geom.Rectangle;
   import net.wg.gui.components.questProgress.interfaces.ITypedViewItem;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IQPItemRenderer extends IUIComponentEx, ITypedViewItem
   {
       
      
      function init(param1:IQPInitData) : void;
      
      function initMetrics(param1:Vector.<IQPMetrics>, param2:int) : void;
      
      function update(param1:IQPProgressData) : void;
      
      function unlock() : void;
      
      function get id() : String;
      
      function set id(param1:String) : void;
      
      function get orderType() : String;
      
      function get progressType() : String;
      
      function get chartMetrics() : Rectangle;
      
      function get isInOrGroup() : Boolean;
      
      function get isHidden() : Boolean;
   }
}
