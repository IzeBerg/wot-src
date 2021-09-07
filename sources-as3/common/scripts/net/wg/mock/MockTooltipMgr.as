package net.wg.mock
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class MockTooltipMgr implements ITooltipMgr
   {
       
      
      public function MockTooltipMgr()
      {
         super();
      }
      
      public function getContainer() : DisplayObjectContainer
      {
         return null;
      }
      
      public function getDefaultTooltipProps() : ITooltipProps
      {
         return null;
      }
      
      public function getNewFormatter() : ITooltipFormatter
      {
         return null;
      }
      
      public function hide() : void
      {
      }
      
      public function show(param1:String, param2:ITooltipProps = null) : void
      {
      }
      
      public function showComplex(param1:String, param2:ITooltipProps = null) : void
      {
      }
      
      public function showComplexWithParams(param1:String, param2:IToolTipParams, param3:ITooltipProps = null) : void
      {
      }
      
      public function showLocal(param1:String, param2:Object, param3:ITooltipProps = null) : void
      {
      }
      
      public function showSpecial(param1:String, param2:ITooltipProps, ... rest) : void
      {
      }
      
      public function showWulfTooltip(param1:String, ... rest) : void
      {
      }
   }
}
