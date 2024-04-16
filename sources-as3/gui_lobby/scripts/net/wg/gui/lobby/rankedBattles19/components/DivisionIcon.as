package net.wg.gui.lobby.rankedBattles19.components
{
   import net.wg.gui.components.common.FrameStateCmpnt;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class DivisionIcon extends FrameStateCmpnt
   {
      
      public static const ICON_GROUP_ID_BIG:String = "groupBig_";
      
      public static const ICON_GROUP_ID_MEDIUM:String = "groupMedium_";
      
      public static const ICON_GROUP_ID_SMALL:String = "groupSmall_";
       
      
      private var _groupID:String = "groupBig_";
      
      private var _iconID:String = "";
      
      public function DivisionIcon()
      {
         super();
      }
      
      private function updateFrame() : void
      {
         if(StringUtils.isNotEmpty(this._groupID) && StringUtils.isNotEmpty(this._iconID))
         {
            frameLabel = this._groupID + this._iconID;
         }
      }
      
      public function set groupID(param1:String) : void
      {
         if(param1 == this._groupID)
         {
            return;
         }
         this._groupID = param1;
         this.updateFrame();
      }
      
      public function set iconID(param1:String) : void
      {
         if(this._iconID == param1)
         {
            return;
         }
         this._iconID = param1;
         this.updateFrame();
      }
   }
}
