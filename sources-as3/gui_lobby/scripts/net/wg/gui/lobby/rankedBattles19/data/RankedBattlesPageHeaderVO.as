package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RankedBattlesPageHeaderVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var rightSideText:String = "";
      
      public var leftSideText:String = "";
      
      public var tooltip:String = "";
      
      private var _useOneSideDescription:Boolean = false;
      
      public function RankedBattlesPageHeaderVO(param1:Object)
      {
         super(param1);
         this.initProps();
      }
      
      private function initProps() : void
      {
         var _loc1_:Boolean = StringUtils.isEmpty(this.leftSideText);
         this._useOneSideDescription = StringUtils.isEmpty(this.rightSideText) || _loc1_;
         if(this._useOneSideDescription)
         {
            if(_loc1_)
            {
               this.leftSideText = this.rightSideText;
            }
            else
            {
               this.rightSideText = this.leftSideText;
            }
         }
      }
      
      public function get useOneSideDescription() : Boolean
      {
         return this._useOneSideDescription;
      }
   }
}
