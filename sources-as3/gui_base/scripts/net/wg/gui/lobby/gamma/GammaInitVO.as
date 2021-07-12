package net.wg.gui.lobby.gamma
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class GammaInitVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var header:String = "";
      
      public var description:String = "";
      
      public var applyLabel:String = "";
      
      public var cancelLabel:String = "";
      
      public var defaultLabel:String = "";
      
      public var gammaTooltip:String = "";
      
      public var currentValue:Number = -1;
      
      public var defaultValue:Number = -1;
      
      public var minValue:Number = -1;
      
      public var maxValue:Number = -1;
      
      public function GammaInitVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
