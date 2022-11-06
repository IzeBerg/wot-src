package net.wg.gui.lobby.rankedBattles19.components.divisionSelector
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.rankedBattles19.components.DivisionIcon;
   import net.wg.gui.lobby.rankedBattles19.components.divisionStatus.DivisionStatus;
   import net.wg.gui.lobby.rankedBattles19.constants.RankedHelper;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DivisionSelectorName extends Sprite implements IDisposable
   {
       
      
      public var divisionIcon:DivisionIcon = null;
      
      public var status:DivisionStatus = null;
      
      public var titleTF:TextField = null;
      
      public var hitMc:Sprite = null;
      
      private var _width:Number = 0;
      
      private var _disposed:Boolean = false;
      
      public function DivisionSelectorName()
      {
         super();
         this.divisionIcon.groupID = DivisionIcon.ICON_GROUP_ID_MEDIUM;
         this.hitArea = this.hitMc;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         hitArea = null;
         this.hitMc = null;
         this.divisionIcon.dispose();
         this.divisionIcon = null;
         this.status.dispose();
         this.status = null;
         this.titleTF = null;
      }
      
      public function setData(param1:DivisionVO) : void
      {
         this.divisionIcon.iconID = param1.id;
         this.status.frameLabel = RankedHelper.getDivisionStatus(param1.isCurrent,param1.isCompleted);
         this.titleTF.htmlText = param1.name;
         App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
         this._width = this.titleTF.x + this.titleTF.width | 0;
         this.hitMc.width = this._width;
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
