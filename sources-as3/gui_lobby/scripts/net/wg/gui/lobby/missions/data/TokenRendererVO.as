package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.missions.interfaces.IConditionVO;
   
   public class TokenRendererVO extends DAAPIDataClass implements IConditionVO
   {
       
      
      public var tokenId:String = "";
      
      public var questId:String = "";
      
      public var isNormalSize:Boolean = true;
      
      public var imgSrc:String = "";
      
      public var imgSrcAlt:String = "";
      
      public var countText:String = "";
      
      public var titleText:String = "";
      
      public var tooltip:String = "";
      
      public var headerText:String = "";
      
      public var descrText:String = "";
      
      public var popoverEnable:Boolean = true;
      
      public function TokenRendererVO(param1:Object)
      {
         super(param1);
      }
      
      public function get useWideTextField() : Boolean
      {
         return false;
      }
      
      public function set useWideTextField(param1:Boolean) : void
      {
      }
   }
}
