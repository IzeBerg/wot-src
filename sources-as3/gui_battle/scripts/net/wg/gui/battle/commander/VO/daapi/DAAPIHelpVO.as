package net.wg.gui.battle.commander.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIHelpVO extends DAAPIDataClass
   {
       
      
      public var keyID:uint = 0;
      
      public var keyText:String = "";
      
      public var isModifier:Boolean = false;
      
      public var rendererLinkage:String = "";
      
      public var tooltipStr:String = "";
      
      public var orderIcon:String = "";
      
      public function DAAPIHelpVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
