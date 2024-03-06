package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.text.TextField;
   import net.wg.gui.lobby.missions.data.MissionDetailsTokenRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.TextFieldEx;
   
   public class MissionDetailsTokenRenderer extends UIComponentEx implements IListItemRenderer
   {
       
      
      public var labelTF:TextField;
      
      public var token:IListItemRenderer;
      
      private var _vo:MissionDetailsTokenRendererVO;
      
      private var _index:int;
      
      private var _owner:UIComponent;
      
      public function MissionDetailsTokenRenderer()
      {
         super();
         visible = false;
      }
      
      override protected function onBeforeDispose() : void
      {
         this.token.dispose();
         this.token = null;
         this.labelTF = null;
         this._vo = null;
         this._owner = null;
         super.onBeforeDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.labelTF.htmlText = this._vo.bigTitleText;
            visible = true;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.labelTF,TextFieldEx.VALIGN_BOTTOM);
         mouseEnabled = false;
      }
      
      public function getData() : Object
      {
         return this._vo;
      }
      
      public function setData(param1:Object) : void
      {
         this._vo = MissionDetailsTokenRendererVO(param1);
         this.token.setData(this._vo);
         this.token.validateNow();
         invalidateData();
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
   }
}
